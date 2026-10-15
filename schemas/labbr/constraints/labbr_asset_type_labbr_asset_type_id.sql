-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbr
-- Object: labbr_asset_type labbr_asset_type_id
-- Type: CONSTRAINT

-- Name: labbr_asset_type labbr_asset_type_id; Type: CONSTRAINT; Schema: labbr; Owner: -
--

ALTER TABLE ONLY labbr.labbr_asset_type
    ADD CONSTRAINT labbr_asset_type_id PRIMARY KEY (asset_type_id);


--
