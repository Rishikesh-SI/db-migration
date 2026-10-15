-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpbl
-- Object: ix_pkl_asset_list_published_date
-- Type: INDEX

-- Name: ix_pkl_asset_list_published_date; Type: INDEX; Schema: labpbl; Owner: -
--

CREATE INDEX ix_pkl_asset_list_published_date ON labpbl.labpbl_asset_list USING btree (published_date);


--
