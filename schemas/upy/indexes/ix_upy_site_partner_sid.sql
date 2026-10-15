-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upy
-- Object: ix_upy_site_partner_sid
-- Type: INDEX

-- Name: ix_upy_site_partner_sid; Type: INDEX; Schema: upy; Owner: -
--

CREATE INDEX ix_upy_site_partner_sid ON upy.upy_site_partner USING btree (site_id);


--
