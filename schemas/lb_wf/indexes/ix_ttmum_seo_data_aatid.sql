-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lb_wf
-- Object: ix_ttmum_seo_data_aatid
-- Type: INDEX

-- Name: ix_ttmum_seo_data_aatid; Type: INDEX; Schema: lb_wf; Owner: -
--

CREATE INDEX ix_ttmum_seo_data_aatid ON lb_wf.lb_wf_seo_data USING btree (asset_id, asset_type_id);


--
