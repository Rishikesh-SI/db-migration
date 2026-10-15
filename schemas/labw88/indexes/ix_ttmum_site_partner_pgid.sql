-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labw88
-- Object: ix_ttmum_site_partner_pgid
-- Type: INDEX

-- Name: ix_ttmum_site_partner_pgid; Type: INDEX; Schema: labw88; Owner: -
--

CREATE INDEX ix_ttmum_site_partner_pgid ON labw88.labw88_page_partner USING btree (page_id);


--
