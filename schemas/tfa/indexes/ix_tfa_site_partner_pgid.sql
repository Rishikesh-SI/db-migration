-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tfa
-- Object: ix_tfa_site_partner_pgid
-- Type: INDEX

-- Name: ix_tfa_site_partner_pgid; Type: INDEX; Schema: tfa; Owner: -
--

CREATE INDEX ix_tfa_site_partner_pgid ON tfa.tfa_page_partner USING btree (page_id);


--
