-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxp1
-- Object: ix_kxp_asset_list_published_date
-- Type: INDEX

-- Name: ix_kxp_asset_list_published_date; Type: INDEX; Schema: labkxp1; Owner: -
--

CREATE INDEX ix_kxp_asset_list_published_date ON labkxp1.labkxp_asset_list USING btree (published_date);


--
