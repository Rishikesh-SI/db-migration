-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labupstox
-- Object: upstox_site_partner_site_id_idx
-- Type: INDEX

-- Name: upstox_site_partner_site_id_idx; Type: INDEX; Schema: labupstox; Owner: -
--

CREATE INDEX upstox_site_partner_site_id_idx ON labupstox.labupstox_site_partner USING btree (site_id);


--
