-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: ix_zeven_asset_draft_atid
-- Type: INDEX

-- Name: ix_zeven_asset_draft_atid; Type: INDEX; Schema: zeven; Owner: -
--

CREATE INDEX ix_zeven_asset_draft_atid ON zeven.zeven_asset_draft USING btree (asset_type_id);


--
