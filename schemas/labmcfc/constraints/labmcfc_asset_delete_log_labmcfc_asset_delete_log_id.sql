-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmcfc
-- Object: labmcfc_asset_delete_log labmcfc_asset_delete_log_id
-- Type: CONSTRAINT

-- Name: labmcfc_asset_delete_log labmcfc_asset_delete_log_id; Type: CONSTRAINT; Schema: labmcfc; Owner: -
--

ALTER TABLE ONLY labmcfc.labmcfc_asset_delete_log
    ADD CONSTRAINT labmcfc_asset_delete_log_id PRIMARY KEY (asset_delete_log_id);


--
