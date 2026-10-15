-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: hsl
-- Object: ix_hsl_site_partner_pgid
-- Type: INDEX

-- Name: ix_hsl_site_partner_pgid; Type: INDEX; Schema: hsl; Owner: -
--

CREATE INDEX ix_hsl_site_partner_pgid ON hsl.hsl_page_partner USING btree (page_id);


--
