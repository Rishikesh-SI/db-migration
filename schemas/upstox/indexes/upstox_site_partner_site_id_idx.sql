-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upstox
-- Object: upstox_site_partner_site_id_idx
-- Type: INDEX

-- Name: upstox_site_partner_site_id_idx; Type: INDEX; Schema: upstox; Owner: -
--

CREATE INDEX upstox_site_partner_site_id_idx ON upstox.upstox_site_partner USING btree (site_id);


--
