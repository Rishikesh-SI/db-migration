-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc
-- Object: labbsc_asset_group labbsc_asset_group_id
-- Type: CONSTRAINT

-- Name: labbsc_asset_group labbsc_asset_group_id; Type: CONSTRAINT; Schema: labbsc; Owner: -
--

ALTER TABLE ONLY labbsc.labbsc_asset_group
    ADD CONSTRAINT labbsc_asset_group_id PRIMARY KEY (asset_group_id);


--
