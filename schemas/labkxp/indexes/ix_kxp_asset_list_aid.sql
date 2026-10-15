-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxp
-- Object: ix_kxp_asset_list_aid
-- Type: INDEX

-- Name: ix_kxp_asset_list_aid; Type: INDEX; Schema: labkxp; Owner: -
--

CREATE INDEX ix_kxp_asset_list_aid ON labkxp.labkxp_asset_list USING btree (asset_id);


--
