-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: fanxp_wf
-- Object: labwf_site_partner_site_id_idx
-- Type: INDEX

-- Name: labwf_site_partner_site_id_idx; Type: INDEX; Schema: fanxp_wf; Owner: -
--

CREATE INDEX labwf_site_partner_site_id_idx ON fanxp_wf.labwf_site_partner USING btree (site_id);


--
