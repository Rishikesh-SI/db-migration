-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tsk
-- Object: tsk_asset_type_meta tsk_asset_type_meta_id
-- Type: CONSTRAINT

-- Name: tsk_asset_type_meta tsk_asset_type_meta_id; Type: CONSTRAINT; Schema: tsk; Owner: -
--

ALTER TABLE ONLY tsk.tsk_asset_type_meta
    ADD CONSTRAINT tsk_asset_type_meta_id PRIMARY KEY (asset_type_meta_id);


--
