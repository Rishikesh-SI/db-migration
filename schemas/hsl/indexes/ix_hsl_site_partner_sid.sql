-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: hsl
-- Object: ix_hsl_site_partner_sid
-- Type: INDEX

-- Name: ix_hsl_site_partner_sid; Type: INDEX; Schema: hsl; Owner: -
--

CREATE INDEX ix_hsl_site_partner_sid ON hsl.hsl_site_partner USING btree (site_id);


--
