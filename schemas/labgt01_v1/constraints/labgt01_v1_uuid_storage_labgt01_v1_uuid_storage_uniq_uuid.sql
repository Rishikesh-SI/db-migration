-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt01_v1
-- Object: labgt01_v1_uuid_storage labgt01_v1_uuid_storage_uniq_uuid
-- Type: CONSTRAINT

-- Name: labgt01_v1_uuid_storage labgt01_v1_uuid_storage_uniq_uuid; Type: CONSTRAINT; Schema: labgt01_v1; Owner: -
--

ALTER TABLE ONLY labgt01_v1.labgt01_v1_uuid_storage
    ADD CONSTRAINT labgt01_v1_uuid_storage_uniq_uuid UNIQUE (uuid);


--
