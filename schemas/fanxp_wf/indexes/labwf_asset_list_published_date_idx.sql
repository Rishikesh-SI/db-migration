-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: fanxp_wf
-- Object: labwf_asset_list_published_date_idx
-- Type: INDEX

-- Name: labwf_asset_list_published_date_idx; Type: INDEX; Schema: fanxp_wf; Owner: -
--

CREATE INDEX labwf_asset_list_published_date_idx ON fanxp_wf.labwf_asset_list USING btree (published_date);


--
