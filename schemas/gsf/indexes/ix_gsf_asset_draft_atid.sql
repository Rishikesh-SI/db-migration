-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gsf
-- Object: ix_gsf_asset_draft_atid
-- Type: INDEX

-- Name: ix_gsf_asset_draft_atid; Type: INDEX; Schema: gsf; Owner: -
--

CREATE INDEX ix_gsf_asset_draft_atid ON gsf.gsf_asset_draft USING btree (asset_type_id);


--
