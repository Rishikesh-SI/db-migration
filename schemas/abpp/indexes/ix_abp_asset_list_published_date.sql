-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: abpp
-- Object: ix_abp_asset_list_published_date
-- Type: INDEX

-- Name: ix_abp_asset_list_published_date; Type: INDEX; Schema: abpp; Owner: -
--

CREATE INDEX ix_abp_asset_list_published_date ON abpp.abp_asset_list USING btree (published_date);


--
