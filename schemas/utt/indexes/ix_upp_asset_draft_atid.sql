-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: utt
-- Object: ix_upp_asset_draft_atid
-- Type: INDEX

-- Name: ix_upp_asset_draft_atid; Type: INDEX; Schema: utt; Owner: -
--

CREATE INDEX ix_upp_asset_draft_atid ON utt.utt_asset_draft USING btree (asset_type_id);


--
