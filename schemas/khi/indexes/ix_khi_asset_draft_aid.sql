-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: khi
-- Object: ix_khi_asset_draft_aid
-- Type: INDEX

-- Name: ix_khi_asset_draft_aid; Type: INDEX; Schema: khi; Owner: -
--

CREATE INDEX ix_khi_asset_draft_aid ON khi.khi_asset_draft USING btree (asset_id);


--
