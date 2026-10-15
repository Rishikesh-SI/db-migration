-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrs_2602
-- Object: ix_ttmum_asset_draft_atid
-- Type: INDEX

-- Name: ix_ttmum_asset_draft_atid; Type: INDEX; Schema: labrs_2602; Owner: -
--

CREATE INDEX ix_ttmum_asset_draft_atid ON labrs_2602.labrs_asset_draft USING btree (asset_type_id);


--
