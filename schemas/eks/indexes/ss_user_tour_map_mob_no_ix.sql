-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: eks
-- Object: ss_user_tour_map_mob_no_ix
-- Type: INDEX

-- Name: ss_user_tour_map_mob_no_ix; Type: INDEX; Schema: eks; Owner: -
--

CREATE UNIQUE INDEX ss_user_tour_map_mob_no_ix ON eks.ss_user_tour_map USING btree (cf_clientid, cf_tourid, mobile_no);


--
