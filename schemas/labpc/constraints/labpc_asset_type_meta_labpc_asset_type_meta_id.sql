-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpc
-- Object: labpc_asset_type_meta labpc_asset_type_meta_id
-- Type: CONSTRAINT

-- Name: labpc_asset_type_meta labpc_asset_type_meta_id; Type: CONSTRAINT; Schema: labpc; Owner: -
--

ALTER TABLE ONLY labpc.labpc_asset_type_meta
    ADD CONSTRAINT labpc_asset_type_meta_id PRIMARY KEY (asset_type_meta_id);


--
