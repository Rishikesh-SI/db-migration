-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmm
-- Object: ix_mum_site_partner_pgid
-- Type: INDEX

-- Name: ix_mum_site_partner_pgid; Type: INDEX; Schema: tmm; Owner: -
--

CREATE INDEX ix_mum_site_partner_pgid ON tmm.tmm_page_partner USING btree (page_id);


--
