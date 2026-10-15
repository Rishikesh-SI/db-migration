-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tsk
-- Object: tsk_asset_list tsk_asset_list_id
-- Type: CONSTRAINT

-- Name: tsk_asset_list tsk_asset_list_id; Type: CONSTRAINT; Schema: tsk; Owner: -
--

ALTER TABLE ONLY tsk.tsk_asset_list
    ADD CONSTRAINT tsk_asset_list_id PRIMARY KEY (asset_list_id);


--
