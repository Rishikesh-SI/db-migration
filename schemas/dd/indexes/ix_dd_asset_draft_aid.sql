-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd
-- Object: ix_dd_asset_draft_aid
-- Type: INDEX

-- Name: ix_dd_asset_draft_aid; Type: INDEX; Schema: dd; Owner: -
--

CREATE INDEX ix_dd_asset_draft_aid ON dd.dd_asset_draft USING btree (asset_id);


--
