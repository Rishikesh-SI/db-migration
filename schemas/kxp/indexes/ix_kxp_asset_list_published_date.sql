-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: kxp
-- Object: ix_kxp_asset_list_published_date
-- Type: INDEX

-- Name: ix_kxp_asset_list_published_date; Type: INDEX; Schema: kxp; Owner: -
--

CREATE INDEX ix_kxp_asset_list_published_date ON kxp.kxp_asset_list USING btree (published_date);


--
