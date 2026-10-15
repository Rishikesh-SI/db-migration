-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstlz
-- Object: ix_kxp_asset_list_published_date
-- Type: INDEX

-- Name: ix_kxp_asset_list_published_date; Type: INDEX; Schema: labstlz; Owner: -
--

CREATE INDEX ix_kxp_asset_list_published_date ON labstlz.labstlz_asset_list USING btree (published_date);


--
