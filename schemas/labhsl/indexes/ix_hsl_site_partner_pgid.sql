-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labhsl
-- Object: ix_hsl_site_partner_pgid
-- Type: INDEX

-- Name: ix_hsl_site_partner_pgid; Type: INDEX; Schema: labhsl; Owner: -
--

CREATE INDEX ix_hsl_site_partner_pgid ON labhsl.labhsl_page_partner USING btree (page_id);


--
