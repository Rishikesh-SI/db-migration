-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: ix_swa_site_partner_pgid
-- Type: INDEX

-- Name: ix_swa_site_partner_pgid; Type: INDEX; Schema: swa; Owner: -
--

CREATE INDEX ix_swa_site_partner_pgid ON swa.swa_page_partner USING btree (page_id);


--
