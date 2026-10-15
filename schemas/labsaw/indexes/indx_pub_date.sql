-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsaw
-- Object: indx_pub_date
-- Type: INDEX

-- Name: indx_pub_date ; Type: INDEX; Schema: labsaw; Owner: -
--

CREATE INDEX "indx_pub_date " ON labsaw.labsaw_asset_list USING btree (published_date DESC) INCLUDE (tagged_entity);


--
