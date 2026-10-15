-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkiug
-- Object: ix_ttmum_asset_draft_atid
-- Type: INDEX

-- Name: ix_ttmum_asset_draft_atid; Type: INDEX; Schema: labkiug; Owner: -
--

CREATE INDEX ix_ttmum_asset_draft_atid ON labkiug.labkiug_asset_draft USING btree (asset_type_id);


--
