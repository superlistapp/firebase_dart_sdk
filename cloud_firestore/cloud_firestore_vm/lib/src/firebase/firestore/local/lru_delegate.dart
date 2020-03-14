// File created by
// Lung Razvan <long1eu>
// on 20/09/2018

import 'dart:async';

import 'package:cloud_firestore_vm/src/firebase/firestore/local/lru_garbage_collector.dart';
import 'package:cloud_firestore_vm/src/firebase/firestore/local/query_data.dart';
import 'package:cloud_firestore_vm/src/firebase/firestore/util/types.dart';

/// Persistence layers intending to use LRU Garbage collection should implement this interface. This interface defines
/// the operations that the LRU garbage collector needs from the persistence layer.
abstract class LruDelegate {
  /// Enumerates all the targets in the QueryCache.
  Future<void> forEachTarget(Consumer<QueryData> consumer);

  Future<int> getSequenceNumberCount();

  /// Enumerates sequence numbers for documents not associated with a target.
  Future<void> forEachOrphanedDocumentSequenceNumber(Consumer<int> consumer);

  /// Removes all targets that have a sequence number less than or equal to [upperBound], and are not present in the
  /// [activeTargetIds] set.
  ///
  /// Returns the number of targets removed.
  Future<int> removeTargets(int upperBound, Set<int> activeTargetIds);

  /// Removes all unreferenced documents from the cache that have a sequence number less than or equal to the given
  /// sequence number.
  ///
  /// Returns the number of documents removed.
  Future<int> removeOrphanedDocuments(int upperBound);

  /// Access to the underlying LRU Garbage collector instance.
  LruGarbageCollector get garbageCollector;

  /// Return the size of the cache in bytes.
  Future<int> get byteSize;
}
