-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ppb
-- Object: ppb_asset_type ppb_asset_type_id
-- Type: CONSTRAINT

-- Name: ppb_asset_type ppb_asset_type_id; Type: CONSTRAINT; Schema: ppb; Owner: -
--

ALTER TABLE ONLY ppb.ppb_asset_type
    ADD CONSTRAINT ppb_asset_type_id PRIMARY KEY (asset_type_id);


--
