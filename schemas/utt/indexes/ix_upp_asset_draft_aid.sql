-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: utt
-- Object: ix_upp_asset_draft_aid
-- Type: INDEX

-- Name: ix_upp_asset_draft_aid; Type: INDEX; Schema: utt; Owner: -
--

CREATE INDEX ix_upp_asset_draft_aid ON utt.utt_asset_draft USING btree (asset_id);


--
