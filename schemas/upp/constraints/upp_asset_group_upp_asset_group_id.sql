-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upp
-- Object: upp_asset_group upp_asset_group_id
-- Type: CONSTRAINT

-- Name: upp_asset_group upp_asset_group_id; Type: CONSTRAINT; Schema: upp; Owner: -
--

ALTER TABLE ONLY upp.upp_asset_group
    ADD CONSTRAINT upp_asset_group_id PRIMARY KEY (asset_group_id);


--
