-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: fanxp_wf
-- Object: labwf_assets_view_view_date_idx
-- Type: INDEX

-- Name: labwf_assets_view_view_date_idx; Type: INDEX; Schema: fanxp_wf; Owner: -
--

CREATE INDEX labwf_assets_view_view_date_idx ON fanxp_wf.labwf_assets_view USING btree (view_date DESC NULLS LAST);


--
