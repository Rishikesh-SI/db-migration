-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: spz
-- Object: ix_spz_site_partner_pgid
-- Type: INDEX

-- Name: ix_spz_site_partner_pgid; Type: INDEX; Schema: spz; Owner: -
--

CREATE INDEX ix_spz_site_partner_pgid ON spz.spz_page_partner USING btree (page_id);


--
