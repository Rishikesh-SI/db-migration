-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: abpp
-- Object: ix_abp_asset_draft_aid
-- Type: INDEX

-- Name: ix_abp_asset_draft_aid; Type: INDEX; Schema: abpp; Owner: -
--

CREATE INDEX ix_abp_asset_draft_aid ON abpp.abp_asset_draft USING btree (asset_id);


--
