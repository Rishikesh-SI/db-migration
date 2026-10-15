-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tsk
-- Object: tsk_asset_group tsk_asset_group_id
-- Type: CONSTRAINT

-- Name: tsk_asset_group tsk_asset_group_id; Type: CONSTRAINT; Schema: tsk; Owner: -
--

ALTER TABLE ONLY tsk.tsk_asset_group
    ADD CONSTRAINT tsk_asset_group_id PRIMARY KEY (asset_group_id);


--
