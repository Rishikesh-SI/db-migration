-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upp
-- Object: ix_upp_site_partner_pgid
-- Type: INDEX

-- Name: ix_upp_site_partner_pgid; Type: INDEX; Schema: upp; Owner: -
--

CREATE INDEX ix_upp_site_partner_pgid ON upp.upp_page_partner USING btree (page_id);


--
