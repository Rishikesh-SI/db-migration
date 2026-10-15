-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: ix_swa_asset_draft_atid
-- Type: INDEX

-- Name: ix_swa_asset_draft_atid; Type: INDEX; Schema: swa; Owner: -
--

CREATE INDEX ix_swa_asset_draft_atid ON swa.swa_asset_draft USING btree (asset_type_id);


--
