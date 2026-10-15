-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tfa
-- Object: ix_tfa_asset_draft_aid
-- Type: INDEX

-- Name: ix_tfa_asset_draft_aid; Type: INDEX; Schema: tfa; Owner: -
--

CREATE INDEX ix_tfa_asset_draft_aid ON tfa.tfa_asset_draft USING btree (asset_id);


--
