-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: ix_isl_site_partner_sid
-- Type: INDEX

-- Name: ix_isl_site_partner_sid; Type: INDEX; Schema: isl; Owner: -
--

CREATE INDEX ix_isl_site_partner_sid ON isl.isl_site_partner USING btree (site_id);


--
