-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: ix_isl_site_partner_pgid
-- Type: INDEX

-- Name: ix_isl_site_partner_pgid; Type: INDEX; Schema: isl; Owner: -
--

CREATE INDEX ix_isl_site_partner_pgid ON isl.isl_page_partner USING btree (page_id);


--
