-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labhsl
-- Object: ix_hsl_site_partner_sid
-- Type: INDEX

-- Name: ix_hsl_site_partner_sid; Type: INDEX; Schema: labhsl; Owner: -
--

CREATE INDEX ix_hsl_site_partner_sid ON labhsl.labhsl_site_partner USING btree (site_id);


--
