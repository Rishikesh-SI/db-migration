-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upy
-- Object: ix_upy_asset_draft_atid
-- Type: INDEX

-- Name: ix_upy_asset_draft_atid; Type: INDEX; Schema: upy; Owner: -
--

CREATE INDEX ix_upy_asset_draft_atid ON upy.upy_asset_draft USING btree (asset_type_id);


--
