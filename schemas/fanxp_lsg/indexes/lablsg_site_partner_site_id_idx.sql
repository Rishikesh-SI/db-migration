-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: fanxp_lsg
-- Object: lablsg_site_partner_site_id_idx
-- Type: INDEX

-- Name: lablsg_site_partner_site_id_idx; Type: INDEX; Schema: fanxp_lsg; Owner: -
--

CREATE INDEX lablsg_site_partner_site_id_idx ON fanxp_lsg.lablsg_site_partner USING btree (site_id);


--
