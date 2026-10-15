-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstlz
-- Object: ix_kxp_asset_draft_atid
-- Type: INDEX

-- Name: ix_kxp_asset_draft_atid; Type: INDEX; Schema: labstlz; Owner: -
--

CREATE INDEX ix_kxp_asset_draft_atid ON labstlz.labstlz_asset_draft USING btree (asset_type_id);


--
