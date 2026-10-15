-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: yho
-- Object: ix_yho_asset_draft_atid
-- Type: INDEX

-- Name: ix_yho_asset_draft_atid; Type: INDEX; Schema: yho; Owner: -
--

CREATE INDEX ix_yho_asset_draft_atid ON yho.yho_asset_draft USING btree (asset_type_id);


--
