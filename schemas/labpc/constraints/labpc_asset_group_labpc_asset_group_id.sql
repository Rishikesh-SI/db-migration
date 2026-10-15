-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpc
-- Object: labpc_asset_group labpc_asset_group_id
-- Type: CONSTRAINT

-- Name: labpc_asset_group labpc_asset_group_id; Type: CONSTRAINT; Schema: labpc; Owner: -
--

ALTER TABLE ONLY labpc.labpc_asset_group
    ADD CONSTRAINT labpc_asset_group_id PRIMARY KEY (asset_group_id);


--
