-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: ix_swa_asset_draft_aid
-- Type: INDEX

-- Name: ix_swa_asset_draft_aid; Type: INDEX; Schema: swa; Owner: -
--

CREATE INDEX ix_swa_asset_draft_aid ON swa.swa_asset_draft USING btree (asset_id);


--
