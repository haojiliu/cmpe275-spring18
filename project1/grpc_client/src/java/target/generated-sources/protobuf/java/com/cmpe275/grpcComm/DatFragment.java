// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: data.proto

package com.cmpe275.grpcComm;

/**
 * Protobuf type {@code grpcComm.DatFragment}
 */
public  final class DatFragment extends
    com.google.protobuf.GeneratedMessage implements
    // @@protoc_insertion_point(message_implements:grpcComm.DatFragment)
    DatFragmentOrBuilder {
  // Use DatFragment.newBuilder() to construct.
  private DatFragment(com.google.protobuf.GeneratedMessage.Builder<?> builder) {
    super(builder);
  }
  private DatFragment() {
    timestampUtc_ = "";
    data_ = com.google.protobuf.ByteString.EMPTY;
  }

  @java.lang.Override
  public final com.google.protobuf.UnknownFieldSet
  getUnknownFields() {
    return com.google.protobuf.UnknownFieldSet.getDefaultInstance();
  }
  private DatFragment(
      com.google.protobuf.CodedInputStream input,
      com.google.protobuf.ExtensionRegistryLite extensionRegistry) {
    this();
    int mutable_bitField0_ = 0;
    try {
      boolean done = false;
      while (!done) {
        int tag = input.readTag();
        switch (tag) {
          case 0:
            done = true;
            break;
          default: {
            if (!input.skipField(tag)) {
              done = true;
            }
            break;
          }
          case 10: {
            String s = input.readStringRequireUtf8();

            timestampUtc_ = s;
            break;
          }
          case 18: {

            data_ = input.readBytes();
            break;
          }
        }
      }
    } catch (com.google.protobuf.InvalidProtocolBufferException e) {
      throw new RuntimeException(e.setUnfinishedMessage(this));
    } catch (java.io.IOException e) {
      throw new RuntimeException(
          new com.google.protobuf.InvalidProtocolBufferException(
              e.getMessage()).setUnfinishedMessage(this));
    } finally {
      makeExtensionsImmutable();
    }
  }
  public static final com.google.protobuf.Descriptors.Descriptor
      getDescriptor() {
    return com.cmpe275.grpcComm.DataProto.internal_static_grpcComm_DatFragment_descriptor;
  }

  protected com.google.protobuf.GeneratedMessage.FieldAccessorTable
      internalGetFieldAccessorTable() {
    return com.cmpe275.grpcComm.DataProto.internal_static_grpcComm_DatFragment_fieldAccessorTable
        .ensureFieldAccessorsInitialized(
            com.cmpe275.grpcComm.DatFragment.class, com.cmpe275.grpcComm.DatFragment.Builder.class);
  }

  public static final int TIMESTAMP_UTC_FIELD_NUMBER = 1;
  private volatile java.lang.Object timestampUtc_;
  /**
   * <code>optional string timestamp_utc = 1;</code>
   */
  public java.lang.String getTimestampUtc() {
    java.lang.Object ref = timestampUtc_;
    if (ref instanceof java.lang.String) {
      return (java.lang.String) ref;
    } else {
      com.google.protobuf.ByteString bs = 
          (com.google.protobuf.ByteString) ref;
      java.lang.String s = bs.toStringUtf8();
      timestampUtc_ = s;
      return s;
    }
  }
  /**
   * <code>optional string timestamp_utc = 1;</code>
   */
  public com.google.protobuf.ByteString
      getTimestampUtcBytes() {
    java.lang.Object ref = timestampUtc_;
    if (ref instanceof java.lang.String) {
      com.google.protobuf.ByteString b = 
          com.google.protobuf.ByteString.copyFromUtf8(
              (java.lang.String) ref);
      timestampUtc_ = b;
      return b;
    } else {
      return (com.google.protobuf.ByteString) ref;
    }
  }

  public static final int DATA_FIELD_NUMBER = 2;
  private com.google.protobuf.ByteString data_;
  /**
   * <code>optional bytes data = 2;</code>
   */
  public com.google.protobuf.ByteString getData() {
    return data_;
  }

  private byte memoizedIsInitialized = -1;
  public final boolean isInitialized() {
    byte isInitialized = memoizedIsInitialized;
    if (isInitialized == 1) return true;
    if (isInitialized == 0) return false;

    memoizedIsInitialized = 1;
    return true;
  }

  public void writeTo(com.google.protobuf.CodedOutputStream output)
                      throws java.io.IOException {
    if (!getTimestampUtcBytes().isEmpty()) {
      com.google.protobuf.GeneratedMessage.writeString(output, 1, timestampUtc_);
    }
    if (!data_.isEmpty()) {
      output.writeBytes(2, data_);
    }
  }

  public int getSerializedSize() {
    int size = memoizedSize;
    if (size != -1) return size;

    size = 0;
    if (!getTimestampUtcBytes().isEmpty()) {
      size += com.google.protobuf.GeneratedMessage.computeStringSize(1, timestampUtc_);
    }
    if (!data_.isEmpty()) {
      size += com.google.protobuf.CodedOutputStream
        .computeBytesSize(2, data_);
    }
    memoizedSize = size;
    return size;
  }

  private static final long serialVersionUID = 0L;
  public static com.cmpe275.grpcComm.DatFragment parseFrom(
      com.google.protobuf.ByteString data)
      throws com.google.protobuf.InvalidProtocolBufferException {
    return PARSER.parseFrom(data);
  }
  public static com.cmpe275.grpcComm.DatFragment parseFrom(
      com.google.protobuf.ByteString data,
      com.google.protobuf.ExtensionRegistryLite extensionRegistry)
      throws com.google.protobuf.InvalidProtocolBufferException {
    return PARSER.parseFrom(data, extensionRegistry);
  }
  public static com.cmpe275.grpcComm.DatFragment parseFrom(byte[] data)
      throws com.google.protobuf.InvalidProtocolBufferException {
    return PARSER.parseFrom(data);
  }
  public static com.cmpe275.grpcComm.DatFragment parseFrom(
      byte[] data,
      com.google.protobuf.ExtensionRegistryLite extensionRegistry)
      throws com.google.protobuf.InvalidProtocolBufferException {
    return PARSER.parseFrom(data, extensionRegistry);
  }
  public static com.cmpe275.grpcComm.DatFragment parseFrom(java.io.InputStream input)
      throws java.io.IOException {
    return PARSER.parseFrom(input);
  }
  public static com.cmpe275.grpcComm.DatFragment parseFrom(
      java.io.InputStream input,
      com.google.protobuf.ExtensionRegistryLite extensionRegistry)
      throws java.io.IOException {
    return PARSER.parseFrom(input, extensionRegistry);
  }
  public static com.cmpe275.grpcComm.DatFragment parseDelimitedFrom(java.io.InputStream input)
      throws java.io.IOException {
    return PARSER.parseDelimitedFrom(input);
  }
  public static com.cmpe275.grpcComm.DatFragment parseDelimitedFrom(
      java.io.InputStream input,
      com.google.protobuf.ExtensionRegistryLite extensionRegistry)
      throws java.io.IOException {
    return PARSER.parseDelimitedFrom(input, extensionRegistry);
  }
  public static com.cmpe275.grpcComm.DatFragment parseFrom(
      com.google.protobuf.CodedInputStream input)
      throws java.io.IOException {
    return PARSER.parseFrom(input);
  }
  public static com.cmpe275.grpcComm.DatFragment parseFrom(
      com.google.protobuf.CodedInputStream input,
      com.google.protobuf.ExtensionRegistryLite extensionRegistry)
      throws java.io.IOException {
    return PARSER.parseFrom(input, extensionRegistry);
  }

  public Builder newBuilderForType() { return newBuilder(); }
  public static Builder newBuilder() {
    return DEFAULT_INSTANCE.toBuilder();
  }
  public static Builder newBuilder(com.cmpe275.grpcComm.DatFragment prototype) {
    return DEFAULT_INSTANCE.toBuilder().mergeFrom(prototype);
  }
  public Builder toBuilder() {
    return this == DEFAULT_INSTANCE
        ? new Builder() : new Builder().mergeFrom(this);
  }

  @java.lang.Override
  protected Builder newBuilderForType(
      com.google.protobuf.GeneratedMessage.BuilderParent parent) {
    Builder builder = new Builder(parent);
    return builder;
  }
  /**
   * Protobuf type {@code grpcComm.DatFragment}
   */
  public static final class Builder extends
      com.google.protobuf.GeneratedMessage.Builder<Builder> implements
      // @@protoc_insertion_point(builder_implements:grpcComm.DatFragment)
      com.cmpe275.grpcComm.DatFragmentOrBuilder {
    public static final com.google.protobuf.Descriptors.Descriptor
        getDescriptor() {
      return com.cmpe275.grpcComm.DataProto.internal_static_grpcComm_DatFragment_descriptor;
    }

    protected com.google.protobuf.GeneratedMessage.FieldAccessorTable
        internalGetFieldAccessorTable() {
      return com.cmpe275.grpcComm.DataProto.internal_static_grpcComm_DatFragment_fieldAccessorTable
          .ensureFieldAccessorsInitialized(
              com.cmpe275.grpcComm.DatFragment.class, com.cmpe275.grpcComm.DatFragment.Builder.class);
    }

    // Construct using com.cmpe275.grpcComm.DatFragment.newBuilder()
    private Builder() {
      maybeForceBuilderInitialization();
    }

    private Builder(
        com.google.protobuf.GeneratedMessage.BuilderParent parent) {
      super(parent);
      maybeForceBuilderInitialization();
    }
    private void maybeForceBuilderInitialization() {
      if (com.google.protobuf.GeneratedMessage.alwaysUseFieldBuilders) {
      }
    }
    public Builder clear() {
      super.clear();
      timestampUtc_ = "";

      data_ = com.google.protobuf.ByteString.EMPTY;

      return this;
    }

    public com.google.protobuf.Descriptors.Descriptor
        getDescriptorForType() {
      return com.cmpe275.grpcComm.DataProto.internal_static_grpcComm_DatFragment_descriptor;
    }

    public com.cmpe275.grpcComm.DatFragment getDefaultInstanceForType() {
      return com.cmpe275.grpcComm.DatFragment.getDefaultInstance();
    }

    public com.cmpe275.grpcComm.DatFragment build() {
      com.cmpe275.grpcComm.DatFragment result = buildPartial();
      if (!result.isInitialized()) {
        throw newUninitializedMessageException(result);
      }
      return result;
    }

    public com.cmpe275.grpcComm.DatFragment buildPartial() {
      com.cmpe275.grpcComm.DatFragment result = new com.cmpe275.grpcComm.DatFragment(this);
      result.timestampUtc_ = timestampUtc_;
      result.data_ = data_;
      onBuilt();
      return result;
    }

    public Builder mergeFrom(com.google.protobuf.Message other) {
      if (other instanceof com.cmpe275.grpcComm.DatFragment) {
        return mergeFrom((com.cmpe275.grpcComm.DatFragment)other);
      } else {
        super.mergeFrom(other);
        return this;
      }
    }

    public Builder mergeFrom(com.cmpe275.grpcComm.DatFragment other) {
      if (other == com.cmpe275.grpcComm.DatFragment.getDefaultInstance()) return this;
      if (!other.getTimestampUtc().isEmpty()) {
        timestampUtc_ = other.timestampUtc_;
        onChanged();
      }
      if (other.getData() != com.google.protobuf.ByteString.EMPTY) {
        setData(other.getData());
      }
      onChanged();
      return this;
    }

    public final boolean isInitialized() {
      return true;
    }

    public Builder mergeFrom(
        com.google.protobuf.CodedInputStream input,
        com.google.protobuf.ExtensionRegistryLite extensionRegistry)
        throws java.io.IOException {
      com.cmpe275.grpcComm.DatFragment parsedMessage = null;
      try {
        parsedMessage = PARSER.parsePartialFrom(input, extensionRegistry);
      } catch (com.google.protobuf.InvalidProtocolBufferException e) {
        parsedMessage = (com.cmpe275.grpcComm.DatFragment) e.getUnfinishedMessage();
        throw e;
      } finally {
        if (parsedMessage != null) {
          mergeFrom(parsedMessage);
        }
      }
      return this;
    }

    private java.lang.Object timestampUtc_ = "";
    /**
     * <code>optional string timestamp_utc = 1;</code>
     */
    public java.lang.String getTimestampUtc() {
      java.lang.Object ref = timestampUtc_;
      if (!(ref instanceof java.lang.String)) {
        com.google.protobuf.ByteString bs =
            (com.google.protobuf.ByteString) ref;
        java.lang.String s = bs.toStringUtf8();
        timestampUtc_ = s;
        return s;
      } else {
        return (java.lang.String) ref;
      }
    }
    /**
     * <code>optional string timestamp_utc = 1;</code>
     */
    public com.google.protobuf.ByteString
        getTimestampUtcBytes() {
      java.lang.Object ref = timestampUtc_;
      if (ref instanceof String) {
        com.google.protobuf.ByteString b = 
            com.google.protobuf.ByteString.copyFromUtf8(
                (java.lang.String) ref);
        timestampUtc_ = b;
        return b;
      } else {
        return (com.google.protobuf.ByteString) ref;
      }
    }
    /**
     * <code>optional string timestamp_utc = 1;</code>
     */
    public Builder setTimestampUtc(
        java.lang.String value) {
      if (value == null) {
    throw new NullPointerException();
  }
  
      timestampUtc_ = value;
      onChanged();
      return this;
    }
    /**
     * <code>optional string timestamp_utc = 1;</code>
     */
    public Builder clearTimestampUtc() {
      
      timestampUtc_ = getDefaultInstance().getTimestampUtc();
      onChanged();
      return this;
    }
    /**
     * <code>optional string timestamp_utc = 1;</code>
     */
    public Builder setTimestampUtcBytes(
        com.google.protobuf.ByteString value) {
      if (value == null) {
    throw new NullPointerException();
  }
  checkByteStringIsUtf8(value);
      
      timestampUtc_ = value;
      onChanged();
      return this;
    }

    private com.google.protobuf.ByteString data_ = com.google.protobuf.ByteString.EMPTY;
    /**
     * <code>optional bytes data = 2;</code>
     */
    public com.google.protobuf.ByteString getData() {
      return data_;
    }
    /**
     * <code>optional bytes data = 2;</code>
     */
    public Builder setData(com.google.protobuf.ByteString value) {
      if (value == null) {
    throw new NullPointerException();
  }
  
      data_ = value;
      onChanged();
      return this;
    }
    /**
     * <code>optional bytes data = 2;</code>
     */
    public Builder clearData() {
      
      data_ = getDefaultInstance().getData();
      onChanged();
      return this;
    }
    public final Builder setUnknownFields(
        final com.google.protobuf.UnknownFieldSet unknownFields) {
      return this;
    }

    public final Builder mergeUnknownFields(
        final com.google.protobuf.UnknownFieldSet unknownFields) {
      return this;
    }


    // @@protoc_insertion_point(builder_scope:grpcComm.DatFragment)
  }

  // @@protoc_insertion_point(class_scope:grpcComm.DatFragment)
  private static final com.cmpe275.grpcComm.DatFragment DEFAULT_INSTANCE;
  static {
    DEFAULT_INSTANCE = new com.cmpe275.grpcComm.DatFragment();
  }

  public static com.cmpe275.grpcComm.DatFragment getDefaultInstance() {
    return DEFAULT_INSTANCE;
  }

  private static final com.google.protobuf.Parser<DatFragment>
      PARSER = new com.google.protobuf.AbstractParser<DatFragment>() {
    public DatFragment parsePartialFrom(
        com.google.protobuf.CodedInputStream input,
        com.google.protobuf.ExtensionRegistryLite extensionRegistry)
        throws com.google.protobuf.InvalidProtocolBufferException {
      try {
        return new DatFragment(input, extensionRegistry);
      } catch (RuntimeException e) {
        if (e.getCause() instanceof
            com.google.protobuf.InvalidProtocolBufferException) {
          throw (com.google.protobuf.InvalidProtocolBufferException)
              e.getCause();
        }
        throw e;
      }
    }
  };

  public static com.google.protobuf.Parser<DatFragment> parser() {
    return PARSER;
  }

  @java.lang.Override
  public com.google.protobuf.Parser<DatFragment> getParserForType() {
    return PARSER;
  }

  public com.cmpe275.grpcComm.DatFragment getDefaultInstanceForType() {
    return DEFAULT_INSTANCE;
  }

}
